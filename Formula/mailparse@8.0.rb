# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT80 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.4.tgz"
  sha256 "1474921b32c7eef825144e2be19b1e9d47505ad409729833fd50c25eacdf9577"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "877e777b119d7e116cab6d9a4b525e29f702d32334e162565df31d6bc5cd3d99"
    sha256 cellar: :any_skip_relocation, big_sur:       "a8173026cbb94819c8f1557cead0c321bef8ff1f0dadf56af19ec723c912d0b7"
    sha256 cellar: :any_skip_relocation, catalina:      "cb59e5a5f550d0dc38a74c4be198e5278a63c6a6468296db82c931e4cb75b5f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c9d43e964c3bc30b0ac456467e7a302ad9e5625095ec0c0427071818ec753e9c"
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
