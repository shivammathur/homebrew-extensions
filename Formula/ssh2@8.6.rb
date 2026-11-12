# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT86 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "ac5dc8a46c6c8c682b55c10a4153dc60e6298bcc7570a81840d81f8a046decff"
    sha256 cellar: :any, arm64_tahoe:       "8cefa46dfdc809f23340707db186f043bf6828943dfc60b7c43ac9227ccb9c80"
    sha256 cellar: :any, arm64_sequoia:     "d4c60db774956c5c8e7831884c1805d5c6e2424d13d4e0fe6d75b429a9334a05"
    sha256 cellar: :any, arm64_linux:       "959f5df27c9c3db5f8411fbe815f092a91db99a99efe92c78bc8e5bf7a1dbb89"
    sha256 cellar: :any, x86_64_linux:      "2bd3441961d9e66c767fb1b28230b1557ce986b947f5ed45001570fe8c63fd73"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
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
