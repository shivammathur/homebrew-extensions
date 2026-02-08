# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d44329e5e607fb7cb2b64616fd764e6ee620753945b5a52dc690ed32fdcf00fc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7f26a393d7f38fcf992c246504a8b1b0b7c7475a4d6b6c24b0d04b9dc6e8b1b9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f0c3f04e830f0b62a7080795cd222a9ab8612644b0d203322b3e0e8d67780a98"
    sha256 cellar: :any_skip_relocation, sonoma:        "b76142c739e52c2afa53a56c15e1c191f2793a4f70c8e19cf5971fe396667bf8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "03b5e97dbd742b151c02cbe6b294ec02cf8abc0ad205302bc9ea1c81b451f8ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2b4bcfd9dfd67de9c8e6abc5e01441f9a3fb6f757f4eb370b8b205e7b0d77cf"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
