# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b7d3efb77de27e87409ab4de64274c54c7cc912a0e324bb590086a14d909b56b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4adb37e601bc6a8d136170f3b85d7a594f653b5b36f2cb2403c9096c92af0e16"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7c90b6292b7be3ccb3b35feefa09a53b78f645e042a52611f11f39aadc9aad0a"
    sha256 cellar: :any_skip_relocation, sonoma:        "93780b19c3b923515fd34beb8c5a53f80ecdd24fa93b3aa0872a44c8c82f77a6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "29ca0384f5c1b7c931c4fb8feea39663bb7f13df9e5eee270f4d2ec65b0cc17a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1319427830a3ea9abde0b0b02141e7117e3c18785d2fd447318a2daa576e940e"
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
