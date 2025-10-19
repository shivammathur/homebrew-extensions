# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT81 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "8f3e81243037a6097bce29c74bc2d93d8604c6e5a7240dbc9ba209a24f6e73c3"
    sha256 cellar: :any,                 arm64_sonoma:  "6af450d3c0a9774365a36a785d187953f4d6642a05e8438eec1d806c77d92c30"
    sha256 cellar: :any,                 arm64_ventura: "57edd632de159437e50760f6ea959cf1ffdec5d14a1fead38afa37d03ebeabc2"
    sha256 cellar: :any,                 sonoma:        "2ec83f3f2bf51dee74a12cd7bb39335642472ee2d4c2d683b3ff0349db7b9afb"
    sha256 cellar: :any,                 ventura:       "d5b9bd4ea447182fa4ee7a2658bc387eeba7c4fe06330d6095bc8e7a3d20b4de"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d465298e66a64fcdb313dc9b10c14b0b5242aeeb7d2375c789cbfb59ad6f2f1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "56c9201b37a7f0c3ec5220c55207027fca57cfb632adc1b38ee52bd5a152f43f"
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
