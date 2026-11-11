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
  revision 1
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "a56189c4c2b227f6843e9b6d4bc298fd5f4b6172ad6b87ecf539ff147d942c85"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "8b1f9338c0377aed8a36d0ae8a346545e7cd910e16b1121c8e3f754d6ef37a6b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "d17ff35c5d31124180ac545ce3221642eee07bbc3d689a76b089b6f1f8a5e450"
    sha256 cellar: :any,                 arm64_linux:       "7e78486a6bc2275ce6fe3f66c00db5f21f601174c1f9cf6f95a8a1edceaa147b"
    sha256 cellar: :any,                 x86_64_linux:      "02614c13830de63ba3d79c0de5ef81331126b642c30bf4f7da514377d1b306bc"
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
