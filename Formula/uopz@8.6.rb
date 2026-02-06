# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT86 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  resource "uopz_pr_185_patch" do
    url "https://patch-diff.githubusercontent.com/raw/krakjoe/uopz/pull/185.patch"
    sha256 "d93be7eb2495a35807a2f4468542d3d4295df5521159964a56b11b4a49418f9e"
  end

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
  end

  def install
    Dir.chdir "uopz-#{version}"
    patch_data = File.read(resource("uopz_pr_185_patch").cached_download)
    filtered_patch = []
    skip = false
    patch_data.each_line do |line|
      if line.start_with?("diff --git a/tests/")
        skip = true
      elsif line.start_with?("diff --git ")
        skip = false
      end
      next if skip

      filtered_patch << line
    end
    File.write("uopz-pr-185.patch", filtered_patch.join)
    system "patch", "-p1", "-i", "uopz-pr-185.patch"
    inreplace "uopz.c", "zend_exception_get_default()", "zend_ce_exception"
    inreplace "src/constant.c", "zval_dtor", "zval_ptr_dtor_nogc"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
