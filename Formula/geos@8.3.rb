# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Geos Extension
class GeosAT83 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "589c5df1ec997736498e2afa9ec074c14bb4866e7ec79c711f5c9d5a7b40432f"
    sha256 cellar: :any, arm64_tahoe:       "17fc86cbf40f96578370662b9d5e5adc494389a1dbdc3ea4e370e0f30e73efe3"
    sha256 cellar: :any, arm64_sequoia:     "c6d6926dfe03884cbb5932aafe5c507e8396d2b383c78cc76dbfe82cd5c6e918"
    sha256 cellar: :any, arm64_linux:       "9bc0a34c732ae2a9762f5875e50f4a90570c6366f352875708bf8ad3fb0d5e19"
    sha256 cellar: :any, x86_64_linux:      "8ad8555e0963e13ee2b664b653f4e38d98c27640c2f1fbee351793685dff5594"
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
