# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.10.0.tgz"
  sha256 "3b552ac17fae44512298f43ec47cd055679d40e8c74b782743021dce77859eb1"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c640e126bae3e0811d75bb8b65cf908885365022ba04fbb057b9719a20d2a968"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c81ebcd4620e03194b2de54b571dbda1c30116c908ff2d20b7ead18dfbbd246d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "93b126c28d0088f8b35ec922aa698a4f82d555cb3aeada41b994b508437f3722"
    sha256 cellar: :any_skip_relocation, sonoma:        "bdfb6ab2968ef9ab19b9ec3fe2ef276eb1a868d579cad9a598a53e9f93d7d816"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3e8b986302bae4548bd35c86d0e6d8bc75a6dc217e34f83e0cdf759a9ec8bb02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "423edfa4054b7ddb1cd91e14313316e7c7052801624ea6a142b72b3f5489389d"
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
