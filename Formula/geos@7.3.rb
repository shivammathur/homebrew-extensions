# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Geos Extension
class GeosAT73 < AbstractPhpExtension
  init
  desc "GEOS PHP extension"
  homepage "https://gitea.osgeo.org/geos/php-geos"
  url "https://gitea.osgeo.org/geos/php-geos/archive/1a1c6a95697359892886a2050570007754ce575e.tar.gz"
  sha256 "750a321384960694a4e9ecb58cf7e216cde40b361dcfe055ed9f09a9b885052e"
  version "1.0.0"
  revision 1
  head "https://gitea.osgeo.org/geos/php-geos.git", branch: "master"
  license all_of: ["LGPL-2.1-or-later", "MIT"]

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c22e1bd471e3d40600c5a5bd5dafb10c7014c9abae8c332543496c2a04568851"
    sha256 cellar: :any, arm64_tahoe:       "99ca7866c2cb29218e178bd227fb975db847c594aba89ef6f3fa1d5bbe79aaa8"
    sha256 cellar: :any, arm64_sequoia:     "1e4da227740a079d01adc4241a93803078eeff1ca14aaac27a231d6c18bc4028"
    sha256 cellar: :any, arm64_linux:       "050e43cf68b39a4b3f5aedf4c71bf38695fa5bf80513e48c65183924f3be80ae"
    sha256 cellar: :any, x86_64_linux:      "aee503ee4269264a4760e20c6ec5186a403e3ff158eeb01b362de433c2168b5c"
  end

  depends_on "geos"

  def install
    inreplace "php_geos.h", '#define PHP_GEOS_VERSION "0.0"', "#define PHP_GEOS_VERSION \"#{version}\""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-geos",
                          "--with-geos-config=#{Utils::Path.formula_opt_bin("geos")}/geos-config"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end

  test do
    (testpath/"geos.php").write <<~PHP
      <?php
      $reader = new GEOSWKTReader();
      $polygon = $reader->read('POLYGON ((0 0, 2 0, 2 2, 0 2, 0 0))');
      $point = $reader->read('POINT (1 1)');
      $writer = new GEOSWKBWriter();
      $wkbReader = new GEOSWKBReader();
      if (phpversion('geos') !== '#{version}' || !GEOSVersion()
          || $polygon->area() != 4 || !$polygon->contains($point)
          || !$reader->read((string) $polygon)->equals($polygon)
          || !$wkbReader->read($writer->write($polygon))->equals($polygon)
          || abs($point->buffer(1, array('quad_segs' => '1'))->area() - 2) > 0.000001) {
          exit(1);
      }
      try {
          $reader->read('INVALID');
          exit(1);
      } catch (Exception $e) {
          echo "GEOS OK";
      }
    PHP
    assert_equal "GEOS OK", shell_output("#{formula_opt_bin(php_formula)}/php -n " \
                                         "-d extension=#{prefix}/geos.so #{testpath}/geos.php")
  end
end
