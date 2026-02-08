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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fe9550f6f828aa3c4306252815b46fb13bf6872cf39914f14c754f14e5362170"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ba2a5949c17933df580042120e7775653ea160538227e1f1b4871329cbf12acb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2a0ca9580a01079def95bbbac6a6dc21397c7c7db47cda5c8ac73069ff3ffc35"
    sha256 cellar: :any_skip_relocation, sonoma:        "6aa2c6922fc041f2dc54b829e9738442f0c3cd1ae0cecd4ff6d3104c05ae69cd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "31112f73476bbb35ac8ffd029bf34d4d588636f51ef40b913109a142cd5f5d31"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "181301c02ad37865774abf6a3d950b94cba7f798dda491ddb47f42d2c7dac2b6"
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
