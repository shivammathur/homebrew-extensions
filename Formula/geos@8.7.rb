# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Geos Extension
class GeosAT87 < AbstractPhpExtension
  init
  desc "GEOS PHP extension"
  homepage "https://gitea.osgeo.org/geos/php-geos"
  url "https://gitea.osgeo.org/geos/php-geos/archive/1a1c6a95697359892886a2050570007754ce575e.tar.gz"
  sha256 "750a321384960694a4e9ecb58cf7e216cde40b361dcfe055ed9f09a9b885052e"
  version "1.0.0"
  revision 3
  head "https://gitea.osgeo.org/geos/php-geos.git", branch: "master"
  license all_of: ["LGPL-2.1-or-later", "MIT"]

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "235e4a19b5febcddc11aa4df5453f2de5d58766fd88135fba81996fb997d365c"
    sha256 cellar: :any, arm64_tahoe:       "22ebc88d8f26ae515cd331d2557285c4d56cd699a588007f3a1ebae794eb6969"
    sha256 cellar: :any, arm64_sequoia:     "f502dd88029cb5bfe839199fedb23b9e68a55366942a934863c59e287e53916d"
    sha256 cellar: :any, arm64_linux:       "f731f1a456f23fc67cc586635a0bf73fb3bb1281b9e333c75fa64f6f5d190f7e"
    sha256 cellar: :any, x86_64_linux:      "15759c65ca2f4f7a387f77cc6afb3d02e857c0e3df18c15f0dffee3c0c9dd823"
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
