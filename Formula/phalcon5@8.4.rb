# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.15.0.tgz"
  sha256 "c0dbe13169a1e03d65a7c8f5a8aca9f00b4e13557337e4651e54a16a393d40d5"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "37bd628339e5e78ed18fb454e4aadbb6f2fc5cfba3f877f753ddd06c30bc17fb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f430d7a525629c29a26cdfdd2ac477035a878866c121de6b8985ae813ef07b05"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0078d14fdab952692ddc6c17cfb6c726ad5e259a70ec25390ecd53e82f30ffca"
    sha256 cellar: :any_skip_relocation, sonoma:        "5f4c04a3facd3803412512ddae8192aec998a3be0ddaba55d5f97a8279a351d2"
    sha256 cellar: :any,                 arm64_linux:   "7d00b481ecc1e79331b6275468ecea94fc10b5f8f1b2ac83b9442e8f7ab40aac"
    sha256 cellar: :any,                 x86_64_linux:  "2ae8fc7a8c0559b02aaaf709654cb52c6e9f6125b68eb3d2c15a818ec9e23529"
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
