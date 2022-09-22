# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT81 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.4.tgz"
  sha256 "1474921b32c7eef825144e2be19b1e9d47505ad409729833fd50c25eacdf9577"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "485eb5dd598487b71b0a8c86e4156ec02d9084f26c9561b7e0ae7f42fbeec22f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "aea9018a619bd76ec153a746be31c219d0e728ceaefe83987d5f28f0442f86b4"
    sha256 cellar: :any_skip_relocation, monterey:       "a3ed4d75e15bca778eb550d641398ade1766eccb2c085939f320c44f96217a4f"
    sha256 cellar: :any_skip_relocation, big_sur:        "dd0580b43c56aaa15dec61cb76f12cd7abb391e7612676f40dcecf9eb341192d"
    sha256 cellar: :any_skip_relocation, catalina:       "8393301e99f969f3f5589c7bf8f8fffeb0a0f8628af7b1b276b364d4c4b50cb7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f054147ff3bc4273cf3faa77b03b677b8ce58797b8eb68061823ca12878b091c"
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
