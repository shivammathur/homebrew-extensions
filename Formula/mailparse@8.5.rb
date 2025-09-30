# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT85 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.9.tgz"
  sha256 "ecb3d3c9dc9f7ce034182d478b724ac3cb02098efc69a39c03534f0b1920922b"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "322919562667aa5fa3ab9533b4893f7f6b13e04b649dfaea86ee7d7ae1a6d0e2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fb7b708f18bcf869128fc99a898bb000cc89a61adb599acff7439d037a5df9c7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1de6b7ef02d80c691a2e30ed4a2bc5b4d28aaf2c17aa9f79673cdcaab4d39b0b"
    sha256 cellar: :any_skip_relocation, sonoma:        "e3266186989203edf3e5d1dc61c35bf2aef69960cfc9447dcfcc13bb1f04840d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8b43aad4bf623ff1814d4f416a787379b7ed0a28c790cb355cef631f366fb43b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "70e4f2f7eb215f0f473cc72185e6844d3f8b2a6f8e78695dcd9beaf4c26d704a"
  end

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
