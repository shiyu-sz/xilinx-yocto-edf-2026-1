FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:ebaz4205-zynq7 = " \
    file://0001-arm-dts-build-zynq-ebaz4205.patch \
    file://0002-spl-add-ebaz4205-stage-markers.patch \
    file://ebaz4205-spl.cfg \
    file://zynq-ebaz4205.dts \
"

# meta-xilinx names the runtime subpackage "-bin" and makes the main package
# depend on it, but its default file pattern only accepts u-boot*.bin.  This
# board deliberately uses the legacy-image u-boot.img for SPL, so package that
# file in the same runtime subpackage instead of leaving -bin empty.
FILES:${PN}-bin:append:ebaz4205-zynq7 = " /boot/u-boot*.img"

# u-boot-xlnx keeps Zynq-7000 DT sources in arch/arm/dts, while the current
# upstream DT copy lives under dts/upstream. Stage this board DT in the path
# expected by UBOOT_USER_SPECIFIED_DTS before the recipe's configure check.
do_configure:prepend:ebaz4205-zynq7 () {
    install -m 0644 ${WORKDIR}/zynq-ebaz4205.dts ${S}/arch/arm/dts/zynq-ebaz4205.dts
}
