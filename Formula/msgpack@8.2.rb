# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "be2702875098cf38db54346536345f86562c13487aaf51f41b331c092352615e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "51940fe2617ea29817f7da8a37fedee18faaa50f5d0b1bbc0af3337fa7fa3a8d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "188f5f0617ad6bd983cabec2583f5b5a01bf12fc86bd3c6f74b55042b45ed124"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f3526ab38744e6b31ac9e7ece3a580a4760fa620551631051c5df5b0f3174859"
    sha256 cellar: :any_skip_relocation, ventura:       "79176d094393d384c3ab50f1680ea7be1b652694d45e5ee2cc5e579491b6b35d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c5a01ba3cc5333210ed9137dbe2c68925d1cb24b064adb5f6267505732c42fc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "44ab2674ae7a23e543ab6a11542489dca0b178e8816f9d7c12aab592c5b0218c"
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
