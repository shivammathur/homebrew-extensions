# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.23.0.tgz"
  sha256 "34738f486ac6ade23b70c4b5b4d8292b5fda3b334ea119b6b35dbcfab24df50d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "3ff0098db8f30479d964d360d65bf4d9112f55bcb36dd405c8bf4d86b2dcaa74"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "4d2eb91159aabc43e5f394e9a0d8b36e3ab782c0be41a25bfeb297690dce5129"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "8e56496e4aa5b20a6a8cab9eecf1d2ff4638220dc8d88b0da10f0cdeccfb76fa"
    sha256 cellar: :any,                 arm64_linux:       "ad63b0c7c00ab13e6a10ea8dd1ffc09629e697ac681b81759f09c76ec144fb10"
    sha256 cellar: :any,                 x86_64_linux:      "5f0aa9ab7fe243ddb386e19d68f731255551ecf4195ed910c83a720e955ec440"
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
