# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT70 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.1.tgz"
  sha256 "e30be355ab79aaea4568692fbd6073fd7c7f50ea8d3cf12edce40fc0c921d868"
  compatibility_version 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "888931a2a157cf2b94361001a78bfdc40402cb98bf1ffcce71d12718fb001ab6"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1d80f6c1e6b6e0b103bd1aec55b90880a770bff02a11e0e2ba85eaa5750cec12"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "210cd37d352476df0ce230785115a64585b00fd11a1264da121152b9dfcb847c"
    sha256 cellar: :any_skip_relocation, sonoma:        "7c06d96802edc9a92dd68779ec177aa0fa566ff5194d23b6a829bfd5a2ced687"
    sha256 cellar: :any,                 arm64_linux:   "8e506f2c5483a788b61b89b5eb36ae1df71ab89b7cf1858c97829b5b2e4331a7"
    sha256 cellar: :any,                 x86_64_linux:  "fdb7f40d8b36926e7011e934880b833b9c80ba5a42cca8ad87140dc8f50057b5"
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
