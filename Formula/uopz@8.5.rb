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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "20e6f48c70a090beb65bf20e8746eb6ed68b7bad8af847b0c90b0e33aa7540f1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6b0081ba6694229b3c14d9a739625b2f53e15fec2a2ce364fed95adb70cc968c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b47f07cae40a1f9fdb611e877dfa2be78aeaf6180e093631acf831e273e7e591"
    sha256 cellar: :any_skip_relocation, sonoma:        "594c46c099fc7f3d49a42a45b30a0c90a47aa3b15514e4219b7168fef3f7bcec"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6e5c131e42287a4cfa539e0c4b14e607f8069b81f0b12237c9b7569821f506cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "08bcb0222a9ff1185aee7c84aa15459088fab64088fb7730bf6cdca37e489e31"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
