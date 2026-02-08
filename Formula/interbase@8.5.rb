# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT85 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "390c2c4b5ec7b6f7850a8ba399bc7e8d52093c82383a498f2ede7dbb16d2effd"
    sha256 cellar: :any,                 arm64_sequoia: "0dff862bb6a1b4bf1b416fa7e3b0d666e4dc780431188d34e645170cd6078b6e"
    sha256 cellar: :any,                 arm64_sonoma:  "db64510b41301c258635317599042dcfae0729b108691ef753608d3076122b94"
    sha256 cellar: :any,                 sonoma:        "f8702c9f8d45f8b4547865e6cd66894bd24c494993c5f5ea7dcf7246f481e3d9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6e66077d56cbea6839313fa5d719d2cdcd92d0396686d90f277268f9f0eb662f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d7326a053b5f98e05db12282b7b8aa333f5f2c15472ab9edb70289af06d9f3b9"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/FirebirdSQL/php-firebird"
  url "https://github.com/FirebirdSQL/php-firebird/archive/refs/tags/v6.1.1-RC.2.tar.gz"
  sha256 "ed1ef8a722e26e1c7123079af7b60d19475ba7bd7f2c8f02f8ae2a31c83828e8"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix

    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
