# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT81 < AbstractPhpExtension
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
    manifest_sha256 "b306eb0c1df4179d59b0306ce929e122dfeb1a8f455907b0bc0e68f3ef569e69"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5579a1a611a1ac12d04515a476d6e7b3f577b54a9d18ef2f2f03aa32e42bf6b4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f304abcb710e59c2eab4a077b8c2ed79bbfb930012565ff04c08f51472153732"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "2e982d921072e70bc43ae31a479162830522263d04a4ab0c19509a3feea913ce"
    sha256 cellar: :any,                 arm64_linux:       "bcaf26a180b6d1cf86ac260fa4e2a9fbcc11ce182e2b6ad63064df6b332d36ee"
    sha256 cellar: :any,                 x86_64_linux:      "61370284c4dcb4350b08c5e3fea7aa7d16c681a7c41973caf8e4494bd4ba6b2c"
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
