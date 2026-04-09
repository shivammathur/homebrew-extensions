# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5dfe1f2ed0d9ed97c78d892fb19462094b45c3bbb2a7cdddfff867be2b44e980"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7f2121a9b43b7d4e97205eb3b7c6cde0a0585ce59145efc0f7af69c992dc1c63"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3866959dcee141c94c0b802f4966dd2ed4cdf49f97cc03d7cc3a96e88100bafc"
    sha256 cellar: :any_skip_relocation, sonoma:        "debef4c983b1446fb04fb1cd75ce29ef45ef462b2cea46ec97d1bd0d979c1645"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "25ef001137392539bb25e636269a4ce414ab1c19021341f71ad60ccca1ea9954"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2c07fd4e93fafac46a4d1caa73e3e58beea919bb9ced0047821a65ff7caf90c"
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
