# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.2.tgz"
  sha256 "1b07edf639177ae3491d0fd8f223193c65f38870b621572f7d5465ca81ae2ac7"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1c4baabb1c4ae15840919ce4f1f8b277db1844da785b34c958a990ec2a49992c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "044cb9c622a03a2c80eb72f979fb23c72ef4ee025b5e2a8984d6ca0bf49f861e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e9fa7ec27985314438fbdd0065da0c8759444e8e5f18532b391cb80012844c91"
    sha256 cellar: :any_skip_relocation, ventura:        "f8a4a4775e7a96b09fd22932dd1b58b1816803226319417e1cc8980af6848de1"
    sha256 cellar: :any_skip_relocation, monterey:       "62021fa7c9e1d6539684cbc44587b4db080c5f54149c5d4f957db96d74ce8aca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2388800a6e1936d648f5eab97b273becbefd0dfbf157ccf13bdfd23bf4b376ec"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
