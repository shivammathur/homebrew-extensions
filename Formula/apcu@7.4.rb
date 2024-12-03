# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "545b9b8f92525f88205e64e6029e9ecf87599c66d1fa1687f4fe732f9fffadde"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "05ed6d2e105dc3722f5430e3db91b22846fd1e9903ae3ec4fa59db5405a6b9e4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "91cd96caad4441c6788b4fdad1d159e3a4bd78dd6cdc6c54dcbef6b57942e6d3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "86ab25e62b8fe9d0778de0281ddd975bfa5c5696b20b81d807f4537a268e7b07"
    sha256 cellar: :any_skip_relocation, ventura:        "c546ec09f8c55ea76b660463d88f0e8c9aea4626d1f38742a5fe2576c3934069"
    sha256 cellar: :any_skip_relocation, monterey:       "282beb5dd01f3a6e6b6609c143198a5cfcd31014ed52e0a72722ada1640e61d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15d397d667b6b07bdd64677625a6badc7159e950c0fd90dc9abf7da2451d4034"
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
