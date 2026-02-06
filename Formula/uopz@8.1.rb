# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT81 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6b9755f061621011292ffa8f69af42fb8d6c716a630c923a4dfcbe128be24679"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "05ff558589fe79f481526076253f13e4dc0be21be139046b0e68a16d85741695"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c07f5430b99df39a04c696062040153d0078e92e4ef327f3c03c715d150b2a37"
    sha256 cellar: :any_skip_relocation, sonoma:        "b474b28fb45e2ca897913a03bb3cbde1a9a519d7836725fa0223f633b8ce37d2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c7ac2e586ab6217864e23ca13e556ac38a2f4ec3365be5ebb0ad0141b2d35717"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d91b86113e6d3e7a336bbe43870be66a0d9a7efbc842ada99a6e4bdf94f16d6d"
  end

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
