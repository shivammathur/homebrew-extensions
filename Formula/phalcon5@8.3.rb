# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.16.0.tgz"
  sha256 "33db2df75a81224f710a2435f7f81c5fe1486ea1fb11579f66c4875a28b4d607"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9545258c77ecb4c2481c90993f823d583530ee3a33eab4d84f88dea0ae0dfc4e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "67e06783a52990ce7668c313a701aa9a692e7ce8d2ee0d1fbdacc62ef6371fe8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f96d65b415d596df813fa1699c4149d1c961b58b1fbbcb5060f70902517efa01"
    sha256 cellar: :any_skip_relocation, sonoma:        "1590c360a7bfb9c572b22f1ccdae572bcaa1471145e6312e69123890accc2406"
    sha256 cellar: :any,                 arm64_linux:   "3e67eb87f3366a25d6ce37866b6ea61ce612cfd6c8d06d90eea4972bbb0c38c4"
    sha256 cellar: :any,                 x86_64_linux:  "8ccab60fb9e872f442d94f5cc6676e094848b262b7cbded9296521c9a06dea8c"
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
