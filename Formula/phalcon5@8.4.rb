# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.2.tgz"
  sha256 "c85b6739e4e6b0816c4f9b4e6f7328d614d63b4f553641732b918df54fe13409"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1e88cf3d70fe7094219a201bf2a9df5e69d9447ad031a1cd8fe54b13aab1e967"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9a938408d901e40a1ced9c44e2af20e77936641aefcbe9bdb0a498dfc536e6d4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a03d31d699e72d54cc238664e0415c3e43de459bc505f6af48f42c15d3d22c86"
    sha256 cellar: :any_skip_relocation, ventura:       "80f1b0a6c8a15012096b35ce35c3e03f8ae7e718bb0f6659d9279c1e8789d4c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90bb29557bfbf6658e0e5be38aaf2200ac8f94cae191635b3aebe459eaa21178"
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
