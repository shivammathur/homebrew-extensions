# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "eb470c8ad83e1aa9f1576d26ae880d92160e6365b0f607dc8d67004456a4b2f4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "86b47cb64a2b0672b66e77eeb7046a5d3188341f5a9aebf6a479741338e8775f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "798ad6eb1848dfd42d5e4245dbe823424754017b22a41bec9a48dafdda2e5026"
    sha256 cellar: :any_skip_relocation, sonoma:        "63cda3c5a6cacc69766c86dc591de02b4f8cb0a72479efadf9b7226bebc02bf7"
    sha256 cellar: :any,                 arm64_linux:   "e5c61c3fa89fd04e086dc2cf651e3c22e3a4191da8c575ff7e078c71062abfb3"
    sha256 cellar: :any,                 x86_64_linux:  "5bbd7dd01e213de0216ca872695598fb242433c2603b07568dbd6dcb661713d7"
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
