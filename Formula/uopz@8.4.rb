# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8a572f5dc0917b746b2f8b94df5fac065eaeb08ca7373168b97844fd1c52e73a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6313ca70311341075314dfe9ca383a9a104f29a48618fc6d34ebb5b9c4fe3d0e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bbd19a90041da7e2aa64dd15a117eb45718d8f6deae66734e770234e630e20af"
    sha256 cellar: :any_skip_relocation, sonoma:        "b0c2bc858463dba79d8bb40408094122dca3c93500f5d9f441c44e62244d0473"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a27797040913a0dd2ab28bc43bf164282a389c86317ecdffb283d4755561a377"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "87c94f81e34bb57f7336f1294ab5b5d710ec906944914e4a75a466113e7761b8"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
