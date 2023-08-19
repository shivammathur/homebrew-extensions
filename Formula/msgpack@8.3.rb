# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT83 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d24791ee4b49ebb63e4887f4feb419727157421e63b29f195ade57351e98c807"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "443b0431cd24885bcc4ba2727cb76ab5d6102350814cc578a629ebc9c2385586"
    sha256 cellar: :any_skip_relocation, ventura:        "11c2106d9ec896194f1dd2c5dd331428cdfca90262a29edc8aaf8cc5ea0f29fb"
    sha256 cellar: :any_skip_relocation, monterey:       "8fc45756332c1fc53b16bb0249ca36d848bd80239437961932a13f3dd85bf5bb"
    sha256 cellar: :any_skip_relocation, big_sur:        "329303001506fc2d12ff5a94d493f81860ecfeeaed8fc0fcb20bf49c5df4faa6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ffaa3f8d43e199591e6a9b7cb8524db652865978fef254f32c637e1da21c7fdf"
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
