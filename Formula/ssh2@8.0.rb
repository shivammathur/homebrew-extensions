# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT80 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.5.0.tgz"
  sha256 "a943427fae39a5503c813179018ae6c500323c8c9fb434e1a9a665fb32a4d7b4"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7ce06e648b7ec6b55f434e38dbb5ece8e475f5df1623dee815e8b1acac34a82b"
    sha256 cellar: :any,                 arm64_sequoia: "9f6e332f990220fa29d1262097588c8e35f90ef3b6392436d93cc589e52075be"
    sha256 cellar: :any,                 arm64_sonoma:  "3ccd0e4411cd9ccb988d39403484af930d385f039e2e60c42744c6aafdcd909f"
    sha256 cellar: :any,                 sonoma:        "ac02d00b97253d319274b7ab057140e606a71f27c861b6b73e19433370df47bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3765f83239e8a4ab8378ef90b7efbf7a2642f68d1fdce2b6fcf4dbe2c8d8f6ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a6e55d8f702dc64813e2ba7f54277f1ee35d44a2b3d440f8fdd35dd5775079b7"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
