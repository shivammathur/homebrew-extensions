# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "00fcaee706c78ac8001c05426da65b42bdacfb2780ad8f2eb38b8a1e3300c83a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4ebf3bac4798820efc7202704b4e2a9cabfc7fab3dbd8705afc8921316126445"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "187e074129f7424a9fa5ff0ae13372a5016b7a7e5fc56b1cb8a89453621f4fa9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "682e71036406d9afdb1de417a7fa6dc883f82ffe0a43cdf317045e2046fdd7c8"
    sha256 cellar: :any_skip_relocation, ventura:        "fd5d836639c3b37de3a302829e42d0a1e4550d048c57cb8310c22527d69f2849"
    sha256 cellar: :any_skip_relocation, monterey:       "c6059a691b0999515f6f57cf55777f51bceb21dccc7af9fe9d43fe31a3a980d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b550d160cc50381fe99a83343ac3d774f37b301a1512b2ae4f112d2ae9e30872"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
