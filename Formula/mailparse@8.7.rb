# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT87 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.0.tgz"
  sha256 "cc5111ae17bfa36efcc5ef23dcf75b6501593ac264c196aad3e39cd4ad765332"
  revision 2
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "22c7a3ce62b1c4a534103c4fd5e25726e1477111bed0364c9f21e56b43e76df4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "623fe8f4286d48ea7f719d6e285dd273baf6173918cc0816931bbe6fb9225c72"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "3cbe77c64afe37c850bd04b7a7e999abed47c49fc7da282da7b6a4f9991c0bb7"
    sha256 cellar: :any,                 arm64_linux:       "1ee0d31f1f5a141802a00ac69fcb06d10b777d48c888f9f31059547dd3c71c7e"
    sha256 cellar: :any,                 x86_64_linux:      "1b0a3c83eab064c6d15159ddef4509288138a2363d57af1e68696c26341ec90b"
  end

  depends_on "re2c" => :build

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
