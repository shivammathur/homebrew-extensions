# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "067d330fc97c401a1e875c239e7372776ac78aecec8dff6f899b24a3a5cbc07c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1bec4a8dba45f7e8c07afda5a404f5b9dd568db93a00591c28a167acd69634fe"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3856e62413cc2f7fa7752dc90f577144f9b7307699e7aee87fe223d0709b1846"
    sha256 cellar: :any_skip_relocation, sonoma:        "ff0ab3ba13b4b7192cb1bc427ed6d8a890229fb9fd4d537d357a37bc4311188d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "83a5a39b6867d7516400e2b16e97ed456542dfdea56cdcfae8042eb696e35cc3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a81f6a4c561cc32a71cf5c309a1584ea385807caa14a337a1d8a4a0157b5da40"
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
