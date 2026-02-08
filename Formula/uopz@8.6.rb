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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c20b21ff93ace97c811f0f43039ac31146d12b166d03483825235d53260f67a5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8d76765222df83337c42c6b82eb5f50f9161968886284cdadaa88bf56732e1c7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "164da2504f791cd8459b543370a7b8ef2e5a1e4ca002f7d3ce3d54a7255d1ba0"
    sha256 cellar: :any_skip_relocation, sonoma:        "71b81a264c2f83c9802c989d15f7ee89995609e76ce3571583e2236a17277f83"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bae5965201907d314ffeeb3392db66e54d9bdefde64721c143445c5923f1dd9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd512000c7394868d87bbca05b8cf684ec98fb1742db9cacede25aa95247b0c7"
  end

  priority "10"

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
