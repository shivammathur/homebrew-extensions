# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT85 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-2.0.2.tgz"
  sha256 "2c63ce727340121044365f0fd83babd60dfa785fa5979fae2520b25dad814226"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b0a68f7082371134e6796d9e802adae64f934a41c356c0ec5ec54ecf3d947207"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7b59e7af2f31882711a48bf8d6ba063cfb5b45318a78cbcb89a997c558c269d3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f2f92f05412a0ceac758dea06df42ae441b02de8373660bf2e9ffb2b202cb21a"
    sha256 cellar: :any_skip_relocation, sonoma:        "c01b13001d85a9d0c758a0f75619bedc34f1cc52d449e5abfbc60dd7ddeba5f9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c0bb0be9a36e90fd427fb3ba9444dd6baccf1f47d6290694b440ecb0da557ef5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8dc3b46aafb8cf6e34913a81dc57780a918a29568dd344c07afba2b22188d8ef"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
