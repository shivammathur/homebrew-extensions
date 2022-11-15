# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT71 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4854d362bc5da039eca574a4809eca9eae36e77167b831a907b33ba8dd6b1455"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9a7d366f9f1957c438fdfeb6220b10f21c2b4e53f0f5cd587890cc5fdd0c76b6"
    sha256 cellar: :any_skip_relocation, monterey:       "84559cfd2cd03cffa255e72868cc0d72ab9ebcf085eea4f040acac5705f9bbf8"
    sha256 cellar: :any_skip_relocation, big_sur:        "9997b453da9d5eeeb3029bb384b1e0a297772a8dc7402b1108b288f866019661"
    sha256 cellar: :any_skip_relocation, catalina:       "ef01d36c510ed1c28c6c72c421515a14ef398da5c84acc51a1045fe130dce3d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6dd7d8f828710678d6186a336ef0c84cf06273b46b73a3aec0a0730cf6a6bf37"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
