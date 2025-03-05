# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT74 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ede0ff5e3be6e14572692dbdedf31d955750b39c6931a8de822d881bfb5ef958"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "54e19b906fc672d22653d123d8b63db2ef63e93beef6c1e5b041c5dca244493b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "795423c9055900681ba5f9f5f03832a4cb045b6f76e16ab7c5fe9fb602ad6d17"
    sha256 cellar: :any_skip_relocation, ventura:       "3c22e01dff957c24870b20c1b2b63dcceb95d459173eeb45aa44ef77349185cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "580896cd27683bf9e647a72a9a75423d3944d845ffaccf0d3e62dd3cc7d320fa"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
