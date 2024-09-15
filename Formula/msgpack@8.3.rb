# typed: true
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
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "4f66650b10abe350ce9e17c100a6229e8f3fabf7dec407f071a37ed8cf344805"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "999c8ecb68c1d3e78a935111030fa854ce9eb155aaf246ec82708f2bbff1732f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e2adfec799585ca4ea8920f2e15c39e4fb54a1926d6e8733a9533572b4c24100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "14a1af376d4c7e156bbea9e6907dffe09cdeacd07b35241b4542d08a25d02d45"
    sha256 cellar: :any_skip_relocation, ventura:        "c82a93ebf2d816c84222ddcc094f2bdfbe984f651bcddf733f4f61be67efe772"
    sha256 cellar: :any_skip_relocation, monterey:       "9baecc03146c8fecca5a05e34db06678341a0d938a309b4b1dcfe5f79a3e5170"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "abcab8c4b82d64314ed82e043530939c5c07533dea0f38c086ec362a2b0bc564"
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
