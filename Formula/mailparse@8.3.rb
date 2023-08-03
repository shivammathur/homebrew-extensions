# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT83 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.5.tgz"
  sha256 "34c685c102a6b57a3f516e9d8fc8ef786bd191c321d0f5d1d3764c1f1ee20620"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "31e50d85dac01dcdac70b38ac25747c8f7df21e45400637c47386f6e086d907f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "993d1e4257d3fd4cf54f899cc3268009812128b0b9582932067c43b791cdfabc"
    sha256 cellar: :any_skip_relocation, ventura:        "bca69b8fc64812a46d66d03b3fa47e9c0c7aa5ed7bdb0514f3ea90efd0c7c032"
    sha256 cellar: :any_skip_relocation, monterey:       "5bfa339a9e5e71e300fa2df949bed7d99ed11551886e66ea0b79eb526f916f32"
    sha256 cellar: :any_skip_relocation, big_sur:        "ca0dbb937635c8aff208b3113e1877d6b288980b87a8b745720154f25b2cf65c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bb607beabda24eeaebe2743cff96e9d2b47e15afc90119eb3ca76e62f335523e"
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
