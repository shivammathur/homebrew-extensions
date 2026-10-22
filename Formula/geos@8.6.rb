# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Geos Extension
class GeosAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "41f9aecfb4469ef1336b383066be34e1fa4752844a237f20b8bf9783cdb27ce2"
    sha256 cellar: :any, arm64_tahoe:       "48d91e47e0cc93f05212a726a5bf516e6486fd6c542fc8569526f3159221592b"
    sha256 cellar: :any, arm64_sequoia:     "ed07132923bce2b2fa2ef6924c33fd417fc9d4674c85baaf15abe5258028416e"
    sha256 cellar: :any, arm64_linux:       "a85c9a6deeb771086d4469952a3eb9ada10a9efd5448b380337cd2f35dcefa37"
    sha256 cellar: :any, x86_64_linux:      "17a93ceaf6fbcd37542da970f77bb0f1cc8a8adb4b5c091f41501fdb12580f4d"
  end

  depends_on "geos"

  def install
    inreplace "php_geos.h", '#define PHP_GEOS_VERSION "0.0"', "#define PHP_GEOS_VERSION \"#{version}\""
    # PHP 8.6 removed these aliases.
    inreplace "geos.c" do |s|
      s.gsub! "zval_dtor", "zval_ptr_dtor_nogc"
      s.gsub! "XtOffsetOf", "offsetof"
    end
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
