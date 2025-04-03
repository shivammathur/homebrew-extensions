# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.1.tgz"
  sha256 "e2a7720c066e7c0d1be646d142634497672b64a4660cea4edb4bcdb2df59be8a"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0b5268a2480ee5ac268840991072dbe21c0c28018677f9e8bfcd3b96669e4b55"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4895dffaea641ad2484e962518e498c41c910aa4f245ec179869022fe8d1401f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b3dea8898c016b5fdd2182e61d1f337b038a1927b5733ba73ac941f0fe37477b"
    sha256 cellar: :any_skip_relocation, ventura:       "be4c1efaeb5aaf96e262be74b7330640b1e158e0f57dfbbeb23819ace3b3148a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "426077c13e604f273c2281941ac2882f759dafd0e667e10d8061bf69389b9164"
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
