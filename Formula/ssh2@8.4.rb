# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT84 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.1.tgz"
  sha256 "2212d8266df54654b282ca681ee9b82f312a776e801b667b288d80f3541741ed"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "fe14722acf3426fe3792eef456b4f67d6c24ebff8c035bb5721047c345677c02"
    sha256 cellar: :any, arm64_tahoe:       "96008eb550b491bdc94d5aafdc5813566bb5813e36b1e9982f7658c39db49ad0"
    sha256 cellar: :any, arm64_sequoia:     "63ed34ed2b8ecd2c6db0f51ed7fdb905550311d253aaa2b467d38485056db9f6"
    sha256 cellar: :any, arm64_linux:       "04a87d237be89b9eb8c13931ee69a41847487df43d1ba4e23ce71b8ad483215d"
    sha256 cellar: :any, x86_64_linux:      "0b2ca68aaf439666c8bf6185d268a2a0f3d1bfd8f6b898f81913368014e3f65a"
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
