# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "108e1385cf96f32d1f588d9b963d6949d5b9971e5163ae3705abe78a84b99e19"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6313c5c269f32818c6af91395e130bb055126fb0a622103b6c4925b995b1169b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "72b43ced5c25875b4e84652d7507effa2df855a658c68d42c46e369b56f07cf4"
    sha256 cellar: :any_skip_relocation, sonoma:        "a2a5cf084b85d78a49c0409348d0a925b361ac4e520cb97b2c427592be351431"
    sha256 cellar: :any,                 arm64_linux:   "a035c1215b8f0d181eebd6364be43983a9262b1aac6ef110eb1bfac0757a6a8f"
    sha256 cellar: :any,                 x86_64_linux:  "bae34a8e5ec99258a3a4d14ce7dbed788d692a652e2b4f454b16ec02aa36f853"
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
