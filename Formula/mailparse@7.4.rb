# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT74 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.0.tgz"
  sha256 "cc5111ae17bfa36efcc5ef23dcf75b6501593ac264c196aad3e39cd4ad765332"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "99788a9c8c268fd88a4f55eaa0e5fe75f9e25d2bbaa475748e5a2ba22879b470"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b3c394dd5807eec077135c826f1a2f1003c81ee8ba269374592322911dc4969d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "69a62dc1b272859a95936a6a10d55a94fb686582de92952a0ade78665a27a8b8"
    sha256 cellar: :any_skip_relocation, sonoma:        "1881dae53be572412d2193dfdb8e15a3e58401c1663414e25aa79b9285f56153"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0b8b8f25c280717724f2229a9e4f1ceeae1549574a401a5021419bb0b42d14f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de7906351474bfbda5626587d60dc5bf06de65b6c9577aeba38cd2f4dbc73eb7"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
