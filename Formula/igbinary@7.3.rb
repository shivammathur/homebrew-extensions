# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "21589174041f67cc94be01b8c028b5421da269243ec9589848c5e50401bf1705"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ca68ac666e8ae84c6d4068110734aba6c91902e418bf3ea378c1c6c57a8c1d2c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "467b5f9ac5b246eb078e2cae8efc84dbde46cb6900277ef25c1584ae8fceeda5"
    sha256 cellar: :any_skip_relocation, ventura:        "bf913c6d056bda5797c003a8cb9edbe14a65b64b0794555b443fed460fc82aa6"
    sha256 cellar: :any_skip_relocation, monterey:       "8a3cff60ffef97e2de0180e4ad372940446d30d4d18db7ae17ade39b565c2632"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7b85da9613c23c0cce3a4bf1f42d2e1fcadba66bc76c0d6a340f680570b16dd"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
