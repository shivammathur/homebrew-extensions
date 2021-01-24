# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT80 < AbstractPhp80Extension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "dfa3a381e3587d114a8c74675046b52bd850482402128069026b3df35f06852a" => :big_sur
    sha256 "92e17da0ce9ee4f69355cfcf9fdd60d38bf5b183d03d9d0dbc63115a224aa2f4" => :arm64_big_sur
    sha256 "87676c87bcea8c202c2c386f599f35028623ae737119da5ec24ab47508d078cc" => :catalina
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/raphf.so"
    write_config_file
  end
end
