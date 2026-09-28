# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Geos Extension
class GeosAT84 < AbstractPhpExtension
  init
  desc "GEOS PHP extension"
  homepage "https://gitea.osgeo.org/geos/php-geos"
  url "https://gitea.osgeo.org/geos/php-geos/archive/889e2b1d9aa6f82995db4dab6891f48c3bacfb59.tar.gz"
  sha256 "fd6a8bb62f9e2c16a2476de87ac26dc069ab6ebfecc585928d2b8b59177c2afc"
  version "1.0.0"
  head "https://gitea.osgeo.org/geos/php-geos.git", branch: "master"
  license all_of: ["LGPL-2.1-or-later", "MIT"]

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d327fa01fdb2846d32a17baad60dcbaceade6a0d59f02091c7ec169595a9621c"
    sha256 cellar: :any, arm64_tahoe:       "27a83d958a689003fcbdd45fd08bc7b5d8a574e9d034f14f0a4c881bd697f613"
    sha256 cellar: :any, arm64_sequoia:     "2c25b14b3740eda7d56994b0b9fb5c7d4b68dd111f3a65a8c54ad21d6cdc0569"
    sha256 cellar: :any, arm64_linux:       "108b8be2d0ba6fb9a50b11caef29017f6f6f4aa04a9c72d5899a590b7293fe20"
    sha256 cellar: :any, x86_64_linux:      "cd66478440687f76edd967d2274c19ff75de43d3c6801fd02b59c0f9c1a8ef56"
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
