# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT84 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.1.tgz"
  sha256 "a9906f465ab2343cb2f3127ee209c72760238745c34878d9bbc1576486219252"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "14ad0360f614a392bccae20a1625225b813957780ce7ea97f1773067da45b057"
    sha256 cellar: :any,                 arm64_big_sur:  "a2282020663aa0ef3e49785d78b5b62d57faea91c242cf19cd8f4a58d1f419ee"
    sha256 cellar: :any,                 ventura:        "e07f773fbae97751f003cbd2281dde8f29d3facdcbe0ea25155bd3b5a91a46aa"
    sha256 cellar: :any,                 monterey:       "78fbed0180f3dbc1208f993a028a09da7b1885390b20a4b40632e4e5dd0d4371"
    sha256 cellar: :any,                 big_sur:        "0267083270ce7a9c4598b986f7f32612084805ca53f12157f6a211b9760cd209"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "391acf5f997e97e3798316f296c65060f859297bda2eba87742c79083303f241"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
