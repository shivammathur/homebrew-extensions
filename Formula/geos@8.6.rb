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
  revision 2
  head "https://gitea.osgeo.org/geos/php-geos.git", branch: "master"
  license all_of: ["LGPL-2.1-or-later", "MIT"]

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "180c61379b5d9f5e3aab0714763405a840693c009685b0b5379331c4319b1c28"
    sha256 cellar: :any, arm64_tahoe:       "652a33ed094e7dd8271af68d0195ce4b47d5f470a940691079b892339cede869"
    sha256 cellar: :any, arm64_sequoia:     "122582a720756241143a8b14372520bb5cbe404dcba0c1023a4a6b86fecc946e"
    sha256 cellar: :any, arm64_linux:       "9b0d3c11e1dcf8acce16ff95723ce5773b4b4a4dfd53390a0712ff69b3808dd1"
    sha256 cellar: :any, x86_64_linux:      "8eb7a4a05d455f3976d13480c7d98ce912ae731f0051b56787d520f12fcc0972"
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
