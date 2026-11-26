# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT84 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.1.tgz"
  sha256 "a9f092ae84f32f15149a09a9a278bb20d3794cbfb57893eab4933814d7ab2fd5"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "7d063e22625433cdb1a8aa2ecb63585b28b72f48732691ea64d50492635e92c7"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "e431a4668b6598ca6ad819bf3161ba09fd04203fcfbae35044aeb13f050e97d6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "095eaf02bec28c2a1445fc0dcc412169cb0b2c634a89ec3b94a49d48b66dd456"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "789598afc9c415b77eb1fd59b06f55cac007a21bb422b64719189e0d063c86ab"
    sha256 cellar: :any,                 arm64_linux:       "2f911fa44d86175691d9a5b7234122189c0d32355d670d170246b9d15a542321"
    sha256 cellar: :any,                 x86_64_linux:      "657f9e2c0d68f511df09be8889d6978056611e3c15a4e1549d23120dfcf0cef8"
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
