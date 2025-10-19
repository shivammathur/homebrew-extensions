# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT56 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.14.1.tar.gz"
  sha256 "7b14371bc9b6d3ba6c69c7712a6e83270a059c177fb83411a66dd08abc4d397f"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "e96f3aeeef6fd39e3a981b5375187cfb07ff498a481446a794682b9cbd575b77"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "cbdc40ec1bcb3f4988ed808940c6ef70b45db520a22f530228f71e99566914c1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "988612a724c1af65da52171969b091cde3f84275798a240743f97f0eb2e6af6d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "eaba70f16a47142357ca6b6e8d75953c9001aae05620278ee0b57208bd451f72"
    sha256 cellar: :any_skip_relocation, sonoma:         "37432daf175d7680d03783b501e2df98f67ed748df3b98d3a259f38cbd747430"
    sha256 cellar: :any_skip_relocation, ventura:        "b3c792f51e2b71a84e8bea95035ee18b505aeb9e3cab24121dbb8279fc924ff1"
    sha256 cellar: :any_skip_relocation, monterey:       "f011740576fc112db94178632e0df679a6f44378f66ccb7a4c7177ea0bfaa78c"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "590af75ff6c7d9fe1c1c6ed1e2f9e43a8594e0bb4f6feeedcdbd876c25c91fd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5a605fbb16d76825372e6e3cf499ff6b2941f46c392b8d4616986e53ec29bf31"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
