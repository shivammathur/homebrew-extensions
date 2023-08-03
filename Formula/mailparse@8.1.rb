# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT81 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.5.tgz"
  sha256 "34c685c102a6b57a3f516e9d8fc8ef786bd191c321d0f5d1d3764c1f1ee20620"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "da5317fbb3b74d77513b65f759913952bb4fb9289968c00c34a1c06a44f10bda"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b48ddd71d54c403afa09affda895a77cec2436d5e3eaf0e8c9540766f693539b"
    sha256 cellar: :any_skip_relocation, ventura:        "89419dafc3aae938d55cb0b1d0722d67ad1597a6e9f1e54fefd3bb6ac3980f9b"
    sha256 cellar: :any_skip_relocation, monterey:       "5c4b05bdaf2b6f1b11d6e791c9b25090fcce630a5fecfaf83703db26f30679b7"
    sha256 cellar: :any_skip_relocation, big_sur:        "6ceb7d0b91681e937eebb82fe4109a4ea09b15936eecff7b98d59d9c94abf534"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0865e3dd9822f7ef2085ff17e3bc0bbc05d7ec011f1945a2ddfd237d7e4d39ec"
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
