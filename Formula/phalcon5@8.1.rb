# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.3.tgz"
  sha256 "f624b4557920aae70f2146eec520b441cf28497269ec81e512712fb3ef05364e"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3108b25696a650e41f01b53024a8b753e2f4bc175b3701df0dae65eb4e50c824"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c1103ed19507303622e83de162685dcf424441acb2f1e581ee1f9ec4855cb3b4"
    sha256 cellar: :any_skip_relocation, ventura:        "b81100017ce5f3842f9a66dbb9576aa30bc9ecd81cb50effb3fa174c6b942ec1"
    sha256 cellar: :any_skip_relocation, monterey:       "c7bb3286696a1e88116af01492694dcae7749b36b3fe33a531a1b9a663aea2ad"
    sha256 cellar: :any_skip_relocation, big_sur:        "3ec666e949e6a8ca11ad0a700d542b3af50cb019163ea11ebea5d63fdcbba920"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2d753d2061341c34f65492426a6e494085b0d6ca3922e5ec9c9032607d6d811c"
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
